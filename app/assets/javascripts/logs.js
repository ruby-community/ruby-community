function Logs(visibility, channel, tableSelector) {
  var self           = this
  this.visibility    = visibility
  this.tableSelector = tableSelector
  this.channel       = channel
  this.fromDate      = null
  this.toDate        = null
  this.messages      = []
  this.jpqMode       = 'hide'
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
    lpad(this.time.getUTCHours(), 2, "0")+":"+lpad(this.time.getUTCMinutes(), 2, "0")+":"+lpad(this.time.getUTCMinutes(), 2, "0")+"Z"
}
p.fromHslColor = function Logs__Message_fromHslColor() {
  var cached = Logs.NickHslColors[this.fromNick]

  if (cached) {
    return cached
  } else {
    var md5Words, hue, saturation, lighting, hsl, pos, max

    md5Words   = CryptoJS.MD5(this.fromNick).words
    pos        = (1<<30)*2
    max        = pos*2
    hue        = Math.round(360/max*(md5Words[0]+pos))
    saturation = Math.round(70/max*(md5Words[1]+pos) + 30)
    lighting   = Math.round(50/max*(md5Words[2]+pos) + 25)
    hsl        = "hsl("+hue+","+saturation+"%,"+lighting+"%)"

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
  console.log("jpqMode: "+this.jpqMode)
  var $tbody = $(this.tableSelector).find('tbody').eq(0)
  Logs.DEBUG = $tbody
  $tbody.empty()
  for(var i=0; i<this.messages.length; i++) {
    message = this.messages[i]
    switch(message.command) {
      case "PRIVMSG":
        $tbody.append($(
          '<tr>'+
            '<td title="'+message.formattedUtcDate()+'">'+message.formattedTime()+'</td>'+
            '<td style="color: '+message.fromHslColor()+';" title="'+message.fromFullIdentifier()+'">'+message.fromNick+'</td>'+
            '<td>'+escapeHtml(message.body)+'</td>'+
          '</tr>'
        ))
        break
      case "JOIN":
        if (this.jpqMode == 'show') {
          $tbody.append($(
            '<tr>'+
              '<td title="'+message.formattedUtcDate()+'">'+message.formattedTime()+'</td>'+
              '<td style="color: '+message.fromHslColor()+';" title="'+message.fromFullIdentifier()+'">* '+message.fromNick+'</td>'+
              '<td>joins channel</td>'+
            '</tr>'
          ))
        }
        break;
      case "PART":
        if (this.jpqMode == 'show') {
          $tbody.append($(
            '<tr>'+
              '<td title="'+message.formattedUtcDate()+'">'+message.formattedTime()+'</td>'+
              '<td style="color: '+message.fromHslColor()+';" title="'+message.fromFullIdentifier()+'">* '+message.fromNick+'</td>'+
              '<td>parts channel</td>'+
            '</tr>'
          ))
        }
        break;
      case "QUIT":
        if (this.jpqMode == 'show') {
          $tbody.append($(
            '<tr>'+
              '<td title="'+message.formattedUtcDate()+'">'+message.formattedTime()+'</td>'+
              '<td style="color: '+message.fromHslColor()+';" title="'+message.fromFullIdentifier()+'">* '+message.fromNick+'</td>'+
              '<td>has quit</td>'+
            '</tr>'
          ))
        }
        break;
    }
  }
}
