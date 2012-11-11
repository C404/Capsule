# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class JsonLoader
    constructor: (@path, @options) ->
        @resContainer = $('<div class="json-displayer-container"></div>')
        @data
        if !@options then @options = {}
        if !@options.limit then !@options.limit = 10000
        if !@options.from then !@options.from = 0
        @buildUrl()
    buildUrl: () ->
        @url = @path
        @url += "?"
        for key, val of @options
            @url += key + "=" + val + "&"
        @url = @url.slice(0, -1)
        @
    loadJson: (callback) ->
        $.getJSON(@url, (@data) => callback?())
        @
    displayTo: (dest) ->
        @dest = $ dest
        @dest.append @resContainer
        @
    display: (limit, attributes) ->
        col = $("<div></div>")
        i = 0
        while (i < limit or limit is undefined) and @data[i]
            elem = @data[i]
            block = $("<div></div>")
            if attributes
                for key, val of attributes
                    block.attr key, val
            block.attr "class", "row-" + i
            if i % 0 then block.addClass "odd" else block.addClass "even"
            block.append("<h4>" + elem.description + "</h4>")
            block.append("<p>" + elem.video + "</p>")
            col.append block
            i++
        @resContainer.append col.contents()
        @

allCapsules = new JsonLoader("/capsuls_range", {from: 0, limit: 10}).loadJson(-> allCapsules.displayTo("#allCapsules").display(1, {class: "all-capsule-view-row"}))

myCapsules = new JsonLoader("/capsuls_range", {from: 0, limit: 10, currentUser: true}).loadJson(-> myCapsules.displayTo("#myCapsules").display(1, {class: "my-capsule-view-row"}))