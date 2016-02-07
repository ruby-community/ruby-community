function Logs(visibility, channel, tableSelector) {
  var self           = this
  this.visibility    = visibility
  this.tableSelector = tableSelector
  this.channel       = channel
  this.fromDate      = null
  this.toDate        = null
  this.messages      = []
  this.jpqMode       = 'smart'
  this.domReady      = $(function() { self.domIsReady() })
}

Logs.NickHslColors = {}
Logs.Message = function Logs__Message(data) {
  this.id           = data.id
  this.time         = data.time
  this.command      = data.command
  this.channel      = data.channel
  this.fromAccount  = data.fromAccount
  this.fromNick     = data.fromNick
  this.fromUsername = data.fromUsername
  this.fromHost     = data.fromHost
  this.body         = data.body
}
Logs.hslColor = function Logs__hslColor(word) {
  var md5Words, hue, saturation, lighting, hsl, pos, max

  md5Words   = CryptoJS.MD5(word).words
  pos        = (1<<30)*2
  max        = pos*2
  hue        = Math.round(360/max*(md5Words[0]+pos))
  saturation = Math.round(70/max*(md5Words[1]+pos) + 30)
  lighting   = Math.round(50/max*(md5Words[2]+pos) + 25)
  hsl        = "hsl("+hue+","+saturation+"%,"+lighting+"%)"

  return hsl
}

var P = Logs.Message
var p = Logs.Message.prototype

P.load = function Logs__Message__load(raw) {
  return new this({
    id:           raw.id,
    time:         new Date(raw.json_time),
    command:      raw.command,
    channel:      raw.channel,
    fromAccount:  raw.from_account,
    fromNick:     raw.from_nick,
    fromUsername: raw.from_username,
    fromHost:     raw.from_host,
    body:         raw.body
  })
}
p.formattedTime = function Logs__Message_formattedTime() {
  return lpad(this.time.getHours(), 2, "0")+":"+lpad(this.time.getMinutes(), 2, "0")
}
p.formattedUtcDate = function Logs__Message_formattedTime() {
  return iso8601UtcDate(this.time)+" "+
    lpad(this.time.getUTCHours(), 2, "0")+":"+lpad(this.time.getUTCMinutes(), 2, "0")+":"+lpad(this.time.getUTCSeconds(), 2, "0")+"Z"
}
p.fromHslColor = function Logs__Message_fromHslColor() {
  var cached = Logs.NickHslColors[this.fromNick]

  if (cached) {
    return cached
  } else {
    var hsl = Logs.hslColor(this.fromNick)
    Logs.NickHslColors[this.fromNick] = hsl

    return hsl
  }
}
p.fromFullIdentifier = function Logs__Message_fromFullIdentifier() {
  return((this.fromAccount ? "$a:"+this.fromAccount : "$~a")+" "+this.fromNick+"!"+this.fromUsername+"@"+this.fromHost)
}

var P = Logs
var p = Logs.prototype

p.changeChannel = function Logs_changeChannel(newChannel) {
  this.channel = newChannel
  this.messages = []
}
p.changeJpqMode = function Logs_changeJpqMode(newMode) {
  this.jpqMode = newMode
  this.render()
}
p.changeDate = function Logs_changeDate(newDate) {
  this.fromDate = newDate
  this.toDate   = new Date(newDate.valueOf()+86400000)
  this.messages = []
}
p.domIsReady = function Logs_domIsReady() {
  this.domReady = true
  if (this.messages.length > 0) this.render()
}
p.load = function Logs_load() {
  var self, url
  self = this
  url  = (this.visibility == 'public' ? '/logs?channel=' : '/private_logs?channel=')+escape(this.channel)
  if (this.fromDate) url += '&from='+iso8601UtcDate(this.fromDate)
  if (this.toDate) url += '&to='+iso8601UtcDate(this.toDate)

  $.getJSON(url).done(function(data) { self.updateData(data) })
}
p.updateData = function Logs_updateData(data) {
  this.messages = data.map(function(message) { return Logs.Message.load(message) })
  if (this.domReady) this.render()
}
p.render = function Logs_render() {
  var $tbody = $(this.tableSelector).find('tbody').eq(0)
  var showLeaves = {}
  $tbody.empty()
  for(var i=0; i<this.messages.length; i++) {
    message = this.messages[i]
    switch(message.command) {
      case "PRIVMSG":
        var text = message.body
        if (text.substr(0,7) == "\x01ACTION") {
          var chop = text.charCodeAt(text.length-1) == 1
          $tbody.append($(
            '<tr>'+
              '<td title="'+message.formattedUtcDate()+'">'+message.formattedTime()+'</td>'+
              '<td style="color: '+message.fromHslColor()+';" title="'+message.fromFullIdentifier()+'">* '+message.fromNick+'</td>'+
              '<td>'+escapeHtml(text.substr(8,text.length-(chop ? 9 : 8)))+'</td>'+
            '</tr>'
          ))
        } else {
          $tbody.append($(
            '<tr>'+
              '<td title="'+message.formattedUtcDate()+'">'+message.formattedTime()+'</td>'+
              '<td style="color: '+message.fromHslColor()+';" title="'+message.fromFullIdentifier()+'">'+message.fromNick+'</td>'+
              '<td>'+escapeHtml(message.body)+'</td>'+
            '</tr>'
          ))
        }
        break
      case "JOIN":
        var showJoin = false
        if (this.jpqMode == 'show') {
          showJoin = true
        } else if (this.jpqMode == 'smart') {
          var relevantNick = message.fromNick
          for(var k=i+1; k<this.messages.length; k++) {
            var checkMessage = this.messages[k]
            if (checkMessage.fromNick == relevantNick) {
              if (checkMessage.command == "PRIVMSG") {
                showJoin = true
                break;
              } else if (checkMessage.command == "NICK") {
                relevantNick = checkMessage.body
              } else if (checkMessage.command == "QUIT" || checkMessage.command == "PART" || checkMessage.command == "JOIN") {
                break
              }
            }
          }
        }
        if (showJoin) {
          showLeaves[message.fromNick] = true
          $tbody.append($(
            '<tr>'+
              '<td title="'+message.formattedUtcDate()+'">'+message.formattedTime()+'</td>'+
              '<td title="'+message.fromFullIdentifier()+'" colspan="2">* <span style="color: '+message.fromHslColor()+';">'+message.fromNick+
              '</span> joins channel ('+message.fromFullIdentifier()+')</td>'+
            '</tr>'
          ))
        }
        break
      case "NICK":
        if (this.jpqMode != 'smart' || showLeaves[message.fromNick]) {
          $tbody.append($(
            '<tr>'+
              '<td title="'+message.formattedUtcDate()+'">'+message.formattedTime()+'</td>'+
              '<td title="'+message.fromFullIdentifier()+'" colspan="2">* <span style="color: '+Logs.hslColor(message.fromNick)+';">'+message.fromNick+
              '</span> is now known as <span style="color: '+Logs.hslColor(message.body)+';">'+message.body+'</span></td>'+
            '</tr>'
          ))
        }
        break
      case "PART":
        if (this.jpqMode == 'show' || showLeaves[message.fromNick]) {
          delete showLeaves[message.fromNick]
          $tbody.append($(
            '<tr>'+
              '<td title="'+message.formattedUtcDate()+'">'+message.formattedTime()+'</td>'+
              '<td title="'+message.fromFullIdentifier()+'" colspan="2">* <span style="color: '+message.fromHslColor()+';">'+message.fromNick+
              '</span> parts channel'+(message.body ? ' ('+message.body+')' : '')+'</td>'+
            '</tr>'
          ))
        }
        break
      case "QUIT":
        if (this.jpqMode == 'show' || showLeaves[message.fromNick]) {
          delete showLeaves[message.fromNick]
          $tbody.append($(
            '<tr>'+
              '<td title="'+message.formattedUtcDate()+'">'+message.formattedTime()+'</td>'+
              '<td title="'+message.fromFullIdentifier()+'" colspan="2">* <span style="color: '+message.fromHslColor()+';">'+message.fromNick+
              '</span> has quit'+(message.body ? ' ('+message.body+')' : '')+'</td>'+
            '</tr>'
          ))
        }
        break
    }
  }
}
