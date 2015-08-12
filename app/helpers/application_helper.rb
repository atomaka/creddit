module ApplicationHelper
  def bootstrap_class_for(flash_type)
    bootstrap_classes[flash_type] || flash_type.to_s
  end

  def page_header
    content_for(:title) || ''
  end

  private

  def bootstrap_classes
    {
      'alert'   => 'alert-warning',
      'error'   => 'alert-danger',
      'notice'  => 'alert-info',
      'success' => 'alert-success'
    }
  end
end
