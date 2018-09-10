Pod::Spec.new do |s|

  s.name         = "TableManager"
  s.version      = "1.10.2"
  s.summary      = "An extension of UITableView. The table the way it should be."
  s.description  = <<-DESC
TableManager is an extension of UITableView. Manipulate your table in an easier way. Add sections and rows. Configure headers and footers. Hide and show rows individually. And this library will handle all the protocols for you. The table the way it should be.
                   DESC

  s.homepage     = "https://github.com/Morbix/TableManager"
  s.license      = "MIT"
  s.author             = { "Henrique Morbin" => "morbin_@hotmail.com" }
  s.social_media_url   = "http://twitter.com/Morbin_"
  s.platform     = :ios, "8.0"
  s.swift_version    = '4.1'

  s.source       = { :git => "https://github.com/Morbix/TableManager.git", :tag => s.version.to_s }
  s.source_files  = 'Pod/Classes/**/*'

end
