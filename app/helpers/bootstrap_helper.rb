module BootstrapHelper
private

  def bootstrap_alert_class(flash_type)
    case flash_type
      when "error" then "alert-danger"
      when "success" then "alert-success"
      else "alert-info"
    end
  end
end
