class MainPanel
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  field :build_name, :type => String
  field :count, :type => Integer
end
