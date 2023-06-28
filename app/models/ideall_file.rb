class IdeallFile
  include Rails.application.routes.url_helpers

  attr_accessor :parent_record, :active_storage, :path, :filename, :content_type,
                :active_storage_file, :forced_position

  def initialize(scope = nil, options)
    @parent_record = scope
    @parent_record = IdeallFile.find_record(options[:parent_class], options[:record_id]) if scope.nil?
    @active_storage = IdeallFile.load_active_storage(self.parent_record, options[:parent_attr_file])
    @path = options[:path]
    @filename = options[:filename]
    @content_type = options[:content_type]
    @forced_position = options[:forced_position]
  end

  def self.find_record(parent_class, record_id)
    result = eval(parent_class).find(record_id)
    result
  end

  def self.load_active_storage(parent_record, parent_attr_file)
    eval("parent_record.#{parent_attr_file}")
  end

  def load_to_record
    return false if path.nil?

    active_storage.attach io: File.open(path), filename: filename, content_type: content_type
    self.active_storage_file, position = get_stored_file
    self.active_storage_file.position = position + 1
    self.active_storage_file.position = forced_position unless forced_position.nil?
    self.active_storage_file.save!
    active_storage.attached?
  end

  def get_stored_file
    case active_storage.class.to_s
    when "ActiveStorage::Attached::One"
      return active_storage, 0
    when "ActiveStorage::Attached::Many"
      return active_storage.last, active_storage.order(:position).last.position
    end
  end

  def delete_by(query)
    case active_storage.class.to_s
    when "ActiveStorage::Attached::One"
      return false
    when "ActiveStorage::Attached::Many"
      blob = active_storage.find_by(query)
      return false if blob.nil?

      blob.purge
      return true
    end
  end

  def get_url
    url_for(active_storage_file)
  end

  def get_base64
    File.open(ActiveStorage::Blob.service.path_for(active_storage_file.key), "rb") do |img|
      "data:#{active_storage_file.content_type};base64," + Base64.strict_encode64(img.read)
    end
  end

  def get_urls
    IdeallFileUrlGetter.new(active_storage_file).get_urls
  end

  def self.get_active_storage(parent_class, record_id, parent_attr_file)
    record = IdeallFile.find_record(parent_class, record_id)
    IdeallFile.load_active_storage(record, parent_attr_file)
  end
end

class IdeallFileUrlGetter
  include Rails.application.routes.url_helpers

  attr_accessor :active_storage

  def initialize(active_storage)
    @active_storage = active_storage
  end

  def get_url
    if active_storage.class.to_s == "ActiveStorage::Attached::One"
      url_for(active_storage) if active_storage.present?
    else
      "No es posible obtener URL de la clase 'ActiveStorage::Attached::Many', intente con 'get_urls'"
    end
  end

  def get_base64
    if active_storage.class.to_s == "ActiveStorage::Attached::One"
      return nil unless active_storage.present? && active_storage.attached?

      File.open(ActiveStorage::Blob.service.path_for(active_storage.key), "rb") do |img|
        json_data = {
          key: active_storage.blob_id,
          name: active_storage.filename,
          content_type: active_storage.content_type,
          size: active_storage.byte_size,
          base64: "data:#{active_storage.content_type};base64," + Base64.strict_encode64(img.read)
        }
        json_data
      end
    else
      "No es posible obtener URL de la clase 'ActiveStorage::Attached::Many', intente con 'get_urls'"
    end
  end

  def get_urls
    urls = []
    case active_storage.class.to_s
    when "ActiveStorage::Attached::One"
      urls << url_for(active_storage)
    when "ActiveStorage::Attached::Many"
      active_storage.each do |file|
        urls << url_for(file)
      end
    end

    urls
  end

  def get_all_base64
    base64_data = []
    case active_storage.class.to_s
    when "ActiveStorage::Attached::One"
      if active_storage.attached?
        File.open(ActiveStorage::Blob.service.path_for(active_storage.key), "rb") do |img|
          json_data = {
            key: active_storage.blob_id,
            name: active_storage.filename,
            content_type: active_storage.content_type,
            size: active_storage.byte_size,
            base64: "data:#{active_storage.content_type};base64," + Base64.strict_encode64(img.read)
          }
          base64_data << json_data
        end
      end
    when "ActiveStorage::Attached::Many"
      active_storage.order(:position).each do |file|
        File.open(ActiveStorage::Blob.service.path_for(file.key), "rb") do |img|
          json_data = {
            key: file.blob_id,
            name: file.filename,
            content_type: file.content_type,
            size: file.byte_size,
            base64: "data:#{file.content_type};base64," + Base64.strict_encode64(img.read),
            position: file.position
          }
          base64_data << json_data
        end
      end
    end

    base64_data
  end
end

# file = IdeallFile.new("User", 17, "avatar", Rails.root.join("tmp/avatar.jpg").to_s, "avatar.jpg", "image/jpg")
# file.load_to_record

# file = IdeallFile.new({
#   parent_class: "Product",
#   record_id: 1,
#   parent_attr_file: "images",
#   path: Rails.root.join("tmp/avatar.jpg").to_s,
#   filename: "avatar.jpg",
#   content_type: "image/jpg"
# })
# file.load_to_record
# file.get_url