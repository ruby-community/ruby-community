module ApplicationHelper
  ActionMapping   = {
    "create".freeze => "new".freeze,
    "update".freeze => "edit".freeze,
  }

private

  def rendered_action
    @_rendered_action ||= begin
      action_name = controller.action_name
      ActionMapping.fetch(action_name, action_name)
    end
  end

  def page_body_id
    @_page_body_id ||= begin
      id = "page_#{controller.controller_path}__#{rendered_action}".tr('/','_')
  
      id == "page_pages_show" ? "#{id}__#{params[:id]}" : id
    end
  end

  def breadcrumb(links)
    *normal, active = *links.to_a
    normal = normal.map { |label, url| %{<li><a href="#{url}">#{h label}</a></li>} }.join("".freeze)
    active = %{<li class="active">#{h active[0]}</li>}

    content_for :breadcrumb, (normal+active).html_safe

    nil
  end
end

__END__
li.active Frequently Asked Questions