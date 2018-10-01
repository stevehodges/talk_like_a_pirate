module I18nHelperMethods
  def setup_temp_folder
    before(:all) do
      tmp_path     = File.join File.dirname(__FILE__), 'tmp'
      @temp_folder = FileUtils.mkdir(tmp_path)[0]
    end
    after(:all) do
      FileUtils.rm_r(@temp_folder) unless @temp_folder.nil?
      @temp_folder = nil
    end
  end

  def tempfile_exists?(target_filename)
    File.exists? tempfile(target_filename)
  end

  def tempfile_contents(target_filename)
    File.read tempfile(target_filename)
  end

  def yaml_for(target_filename)
    YAML.load(tempfile_contents(target_filename))
  end

  def tempfile(target_filename)
    File.join(@temp_folder, target_filename)
  end

  def remove_temp_files
    return if @temp_folder.nil? || @temp_folder == ''
    Dir.glob(@temp_folder).each do |file_path|
      next if ['.','..',@temp_folder].include?(file_path)
      FileUtils.remove_entry file_path
    end
  end

  def create_source_file(target_path, target_filename)
    target_path = File.join [@temp_folder, target_path].compact
    FileUtils.mkdir_p(target_path) unless Dir.exists?(target_path)

    source_path      = File.join File.dirname(__FILE__), 'source_template.yml'
    target_file_path = File.join target_path, target_filename
    FileUtils.copy source_path, target_file_path
  end

  def delete_config_file
    FileUtils.remove_entry File.dirname(target_file_path)
  end
end