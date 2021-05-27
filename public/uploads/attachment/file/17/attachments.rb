FactoryBot.define do
  factory :attachment do
    # file { Rack::Test::UploadedFile.new("#{Rails.root}/spec/factories/attachments.rb") }
    file { ActionDispatch::Http::UploadedFile.new(:tempfile => File.new("#{Rails.root}/spec/factories/attachments.rb"),
                                                  :filename => "attachments.rb") }
  end

  factory :invalid_attachment, class: 'Attachment' do
    file { "" }
  end
end
