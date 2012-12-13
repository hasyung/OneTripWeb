#encoding : utf-8
module ApplicationHelper

	def yield_for(content_sym, default)
    output = content_for(content_sym)
    output = default if output.blank?
    output
  end

  def title(page_title)
	  content_for(:title) { page_title }
	end

  def icon_link_to(icon_name, path, options = {})
    name = content_tag(:i, "", :class => "icon-#{icon_name} icon-large")
    rel = options[:rel].blank? ? nil : :tooltip
    title = options[:title].blank? ? nil : options[:title]
    remote = options[:remote].blank? ? nil : true
    confirm = options[:confirm].blank? ? nil : {:confirm => t("helpers.messages.confirm")}
    method = options[:method].blank? ? nil : options[:method]
    link_to(name, path, :rel => rel, :title => title, :remote => remote, :data => confirm, :method => method)
  end

  def current_user_html
    html = ""
    if !current_user.profile.blank?
      html += current_user.profile.real_name
      html += " [#{current_user.profile.position}]" if !current_user.profile.position.blank?
    else
      html += current_user.email
    end
    html
  end

  def bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      type = :success if type == :notice
      type = :error   if type == :alert
      text = content_tag(:div, link_to("×", "#", :class => "close", "data-dismiss" => "alert") + message, :class => "alert fade in alert-#{type}")
      flash_messages << text if message
    end
    flash_messages.join("\n").html_safe
  end

  def alert_html(message, type = :success)
    text = ""
    text = content_tag(:div, 
      link_to(raw("&times;"), "#", :class => "close", "data-dismiss" => :alert) + message, 
      :class => "alert fade in alert-#{type}") if message
    text.html_safe
  end

	def error_messages_for(*params)
    options = params.extract_options!.symbolize_keys

    objects = Array.wrap(options.delete(:object) || params).map do |object|
      object = instance_variable_get("@#{object}") unless object.respond_to?(:to_model)
      object = convert_to_model(object)

      if object.class.respond_to?(:model_name)
        options[:object_name] ||= object.class.model_name.human.downcase
      end

      object
    end

    objects.compact!
    count = objects.inject(0) {|sum, object| sum + object.errors.count }

    unless count.zero?
      html = {}
      [:id, :class].each do |key|
        if options.include?(key)
          value = options[key]
          html[key] = value unless value.blank?
        else
          html[key] = 'errorExplanation'
        end
      end
      options[:object_name] ||= params.first

      I18n.with_options :locale => options[:locale], :scope => [:errors, :template] do |locale|
        header_message = if options.include?(:header_message)
          options[:header_message]
        else
          locale.t :header, :count => count, :model => options[:object_name].to_s.gsub('_', ' ')
        end

        message = options.include?(:message) ? options[:message] : locale.t(:body)

        error_messages = objects.sum do |object|
          object.errors.full_messages.map do |msg|
            content_tag(:li, msg)
          end
        end.join.html_safe

        contents = ''
        contents << content_tag(:a, raw("&times;"), :class => "close", "data-dismiss" => :alert) unless options[:close].blank?
        contents << content_tag(options[:header_tag] || :h2, header_message) unless header_message.blank?
        contents << content_tag(:p, message) unless message.blank?
        contents << content_tag(:ul, error_messages)

        content_tag(:div, contents.html_safe, html)
      end
    else
      ''
    end
  end

  def show_link(object, content = "Show")
    link_to(content, object) if can?(:read, object)
  end

  def edit_link(object, content = "Edit")
    link_to(content, [:edit, object]) if can?(:update, object)
  end

  def destroy_link(object, content = "Destroy")
    link_to(content, object, :method => :delete, :confirm => "Are you sure?") if can?(:destroy, object)
  end

  def create_link(object, content = "New")
    if can?(:create, object)
      object_class = (object.kind_of?(Class) ? object : object.class)
      link_to(content, [:new, object_class.name.underscore.to_sym])
    end
  end
  
  def polymorphic_detailed_path(model,model_detailed)
    path = ""
    case model.class.name
    when "Place"
      case model_detailed.class.name
      when "Image"
        path = place_image_path(model.key,model_detailed.id)
      when "Video"
        path = place_video_path(model.key,model_detailed.id)
      when "Audio"
        path = place_audio_path(model.key,model_detailed.id)
      when "Article"
        path = place_article_path(model.key,model_detailed.id)
      end
    when "Minority"
      case model_detailed.class.name
      when "Map"
        path = minority_image_path(model.key,model_detailed.id)
      when "Video"
        path = minority_video_path(model.key,model_detailed.id)
      when "Audio"
        path = minority_audio_path(model.key,model_detailed.id)
      when "Article"
        path = minority_article_path(model.key,model_detailed.id)
      end
    end
    path
  end
  
  def polymorphic_area_path(model)
    path = ""
    case model.class.name
    when "Place"
      path = place_path(model.key)
    when "Minority"
      path = minority_path(model.key)
    end
    path
  end
  
end
