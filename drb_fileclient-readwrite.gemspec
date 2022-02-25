Gem::Specification.new do |s|
  s.name = 'drb_fileclient-readwrite'
  s.version = '0.1.6'
  s.summary = 'A DRb file reader and writer client to access the ' +
      'DRb_fileserver service.'
  s.authors = ['James Robertson']
  s.files = Dir['lib/drb_fileclient-readwrite.rb']
  s.add_runtime_dependency('drb_fileclient-reader', '~> 0.1', '>=0.1.3')
  s.signing_key = '../privatekeys/drb_fileclient-readwrite.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'digital.robertson@gmail.com'
  s.homepage = 'https://github.com/jrobertson/drb_fileclient-readwrite'
end
