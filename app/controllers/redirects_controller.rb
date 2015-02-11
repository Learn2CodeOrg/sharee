class RedirectsController < ApplicationController

  def index
    id = request.path.tr!('/','')

    link = Link.find_by(id: id)
    if link
      OpenAction.create!(link: link)
      return redirect_to link.url + (link.url.include?('?') ? '&' : '?') + "sharee=#{link.id}"
    else
      return render text: 'Sorry!'
    end
  end
end
