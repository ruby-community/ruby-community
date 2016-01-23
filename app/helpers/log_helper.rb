require "digest/md5"

module LogHelper
  HueBase        = 360.0/(1<<32)
  SaturationBase = 50.0/(1<<32)
  LightingBase   = 50.0/(1<<32)

private

  def colored_nick(nick)
    fhue, fsaturation, flighting, _u2 = Digest::MD5.digest(nick).unpack("NNNN".freeze)

    hue        = (fhue * HueBase).round
    saturation = (fsaturation * SaturationBase + 25).round
    lighting   = (flighting * LightingBase + 25).round

    %{<span style="color: hsl(#{hue}, #{saturation}%, #{lighting}%);">#{h nick}</span>:}.html_safe
  end
end
