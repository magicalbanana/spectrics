class CiBuildsChannel < ApplicationCable::Channel
  include NoBrainer::Streams

  def subscribed
    nobrainer_stream_from CiBuild.all, include_initial: true
  end

end
