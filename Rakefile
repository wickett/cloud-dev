task :default => [:setup, :lint, :test]

task :setup do 
  sh "librarian-chef install"
end

task :test do 
  sh "rspec cookbooks/cloud-dev/spec"
end

task :lint do 
  sh "foodcritic cookbooks/cloud-dev --epic-fail any"
end

