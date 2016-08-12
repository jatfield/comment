class AddAttachmentPhotoToUploads < ActiveRecord::Migration
  def self.up
    change_table :uploads do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :uploads, :photo
  end
end
