module ApplicationHelper
  def render_item_category(category)
    render partial: "whiteboards/shared/item_category", locals: { category: category }
  end

  def next_items(location)
    render(
      partial: "standups/shared/arrow",
      locals: {
        direction: :right,
        location: location,
      }
    ) + render(
      partial: "standups/shared/route_keypress",
      locals: {
        keypress: "right",
        location: location,
      }
    )

  end

  def previous_items(location)
    render(
      partial: "standups/shared/arrow",
      locals: {
        direction: :left,
        location: location,
      }
    ) + render(
      partial: "standups/shared/route_keypress",
      locals: {
        keypress: "left",
        location: location,
      }
    )
  end
end
