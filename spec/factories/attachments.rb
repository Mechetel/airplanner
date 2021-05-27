FactoryBot.define do
  factory :attachment do
    file do
      ActionDispatch::Http::UploadedFile.new(tempfile: File.new(Rails.root.join('spec/factories/attachments.rb')),
                                             filename: 'attachments.rb')
    end
  end

  factory :invalid_attachment, class: 'Attachment' do
    file { '' }
  end
end
