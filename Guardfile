# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :compass do

endwatch('^app/styles/(.*)\.s[ac]ss')
end

guard :livereload do
	watch('index.html')
	watch(%r{app/scripts/.+\.js})
	watch(%r{app/templates/.+\.(jst|hbs|handlebars)$})
	watch(%r{assets/.+\.(css|js|html)})
end

guard :bundler do
	endwatch('Gemfile')
end
