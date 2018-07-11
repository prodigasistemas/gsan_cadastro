module ApplicationHelper

  def wicked_pdf_image_tag_for_public(img, options={})
    if img[0] == "/"        
      new_image = img.slice(1..-1)
      image_tag "file://#{Rails.root.join('public', new_image)}", options
    else        
        image_tag img
    end
  end

  def data_emissao(format='%d/%m/%Y às %H:%M')
  	data = Time.now
  	data.strftime(format)
  end

  def salvar_pdf(pdf, path)
    Dir.mkdir(path) unless File.exists?(path)

    save_path = Rails.root.join(path, @file_name)
    File.open(save_path, 'wb') do |file|
      file << pdf
    end
  end

end