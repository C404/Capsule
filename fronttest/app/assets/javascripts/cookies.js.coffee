window.createCookie = (name,value,days) ->
  if days
    date = new Date()
    date.setTime(date.getTime()+(days*24*60*60*1000))
    expires = "; expires="+date.toGMTString()
  else
    expires = ""
  window.document.cookie = name+"="+value+expires+"; path=/"

window.readCookie = (name) ->
  nameEQ = name + "="
  ca = window.document.cookie.split(';')
  cookie = null
  for i in [0..(ca.length - 1)]
    do (i, ca) ->
      c = ca[i]
      while (c.charAt(0)==' ')
        c = c.substring(1,c.length)
      if (c.indexOf(nameEQ) == 0)
        cookie = c.substring(nameEQ.length,c.length)
  return cookie
  
window.eraseCookie = (name) ->
  createCookie(name,"",-1)
