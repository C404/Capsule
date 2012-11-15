# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class JsonLoader
    constructor: (@path = "", @from = 0, @len = 100, @params = {}) ->
        @buildUrl()
    buildUrl: () ->
        @url = @path
        @url += "?from=" + @from + "&limit=" + (@len + 1)
        for key, val of @params
            @url += "&" + key + "=" + val
        @
    attachParser: (@parser) ->
        if @parser then @parser.jsonLoader = @
        @
    launch: () ->
        $.getJSON(@url, (@data) =>
            if @data.length >= @len + 1
                more = true
                @data = @data.slice(0, -1)
            else
                more = false
            @parser.display(@data, more)
        )
        @from += @len
        @buildUrl()
        @

class JsonVideoParser
    constructor: (@domElem) ->
        @jsonLoader = null
        @
    loadVideo: (id) ->
        url = "http://www.dailymotion.com/services/oembed?format=javascript&url=http%3A//www.dailymotion.com/video/#{id}&callback=?"
        domelem = $('<div class="video-container"></div>')
        $.getJSON(url, (@data) =>
            $(@data.html).appendTo(domelem)
        )
        domelem
    display: (data, more) ->
        for elem in data
            block = $("<div></div>")
            block.append($("<h4>" + elem.description + "</h4>"))
            block.append(@loadVideo(elem.video))
            block.appendTo(@domElem)
        if more
            @more = $('<button class="btn">More</button>').appendTo(@domElem)
            @more.click(=>
                @more.remove()
                @jsonLoader.launch()
            )
$("document").ready ->
    new JsonLoader("/capsuls_datas", 0, 10).attachParser(new JsonVideoParser($("#allCapsules"))).launch()
    new JsonLoader("/capsuls_datas", 0, 10, {currentUser: true}).attachParser(new JsonVideoParser($("#myCapsules"))).launch()