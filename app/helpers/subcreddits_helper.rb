module SubcredditsHelper
  def subcreddit_name(subcreddit)
    if subcreddit
      content_for(:title) { link_to subcreddit.name, subcreddit }
    else
      content_for(:title) { link_to 'frontpage', root_path }
    end
  end
end
