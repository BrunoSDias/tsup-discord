class Utils::File
  def self.convert_byte_to_kilobyte(size)
    "#{size/1024} kb"
  end
end