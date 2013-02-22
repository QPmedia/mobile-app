Qpondo mobile app
=================

Installation
------------

To setup Grunt and Bundler on your system, you must run the following block of commands:

```bash
npm -g grunt-cli
gem install bundler
gem install rubygems-bundler
gem regenerate_binstubs
```

Then cd into your repository clone and execute the following commands to install the requirements.

```bash
npm install
bundle install
compass compile
```

Execute `grunt`, open `http://localhost:8000` in your favorite browser and enjoy :smiley:

Directory structure
-------------------

    .
    ├── app
    │   ├── coffeescripts
    │   │   ├── collections
    │   │   ├── models
    │   │   └── views
    │   ├── images
    │   ├── scss
    │   └── templates
    ├── build
    │   ├── debug
    │   └── production
    └── vendor
        └── javascripts
            ├── libs
            └── plugins

