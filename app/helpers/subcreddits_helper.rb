# helpers/subcreddits__helper.rb
module SubcredditsHelper
  def subcreddit_name(subcreddit = '')
    if subcreddit.blank?
      link = link_to 'frontpage', root_path
    else
      link =  link_to subcreddit.name, subcreddit
    end

    content_for(:title) { link }
  end
end
