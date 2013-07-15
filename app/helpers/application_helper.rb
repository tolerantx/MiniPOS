module ApplicationHelper
  FLASH_NOTICE_KEYS = [:error, :notice, :warning, :alert, :success]

  def flash_messages
    return unless messages = flash.keys.select{|k| FLASH_NOTICE_KEYS.include?(k)}
    formatted_messages = messages.map do |type|
      content_tag :div, :class => "alert alert-#{type.to_s}" do
        message_for_item(flash[type], flash["#{type}_item".to_sym])
      end
    end
    flash.discard
    raw formatted_messages.join
  end

  def message_for_item(message, item = nil)
    msg = "#{link_to('x', '#', :class => 'close')}"
    if item.is_a?(Array)
      msg << content_tag(:p) do
        message % can_link_to(*item)
      end
    else
      msg << content_tag(:p) do
        message % item
      end
    end
    raw msg
  end

  def error_messages(object)
    if object.errors.any?
      header_error = t("errors.header", :number => object.errors.count)

      content_tag(:div, class: "alert alert-error") do
        link_to("x", "", :class => "close", :'data-dismiss' => "alert") +

        content_tag(:h5, header_error) +
        content_tag(:ul) do
          object.errors.full_messages.collect do |message|
            content_tag(:li, message)
          end.join.html_safe
        end

      end
    end
  end

  def pagination(object)
    if object.count > WillPaginate.per_page
      content_tag(:div, will_paginate(object), :class => 'apple_pagination')
    end
  end
end
