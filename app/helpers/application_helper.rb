module ApplicationHelper
  def portrait_url(type, id, size)
    case type.to_sym
    when :character
      "https://imageserver.eveonline.com/Character/#{id}_#{size}.jpg"
    when :corporation
      "https://imageserver.eveonline.com/Corporation/#{id}_#{size}.png"
    when :alliance
      "https://imageserver.eveonline.com/Alliance/#{id}_#{size}.png"
    end
  end
end
