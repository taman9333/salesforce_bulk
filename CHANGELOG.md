## Changelog

**4.0.2** (September 21, 2022)

* Avoid NoMethodError exceptions on nil when authentication response is a redirect ([#24](https://github.com/javierjulio/salesforce_bulk/pull/24) - thanks [@anero](https://github.com/anero))

**4.0.1** (April 13, 2021)

* Escape special characters in password during authentication ([#23](https://github.com/javierjulio/salesforce_bulk/pull/23) - thanks [@lavaturtle](https://github.com/lavaturtle))

**4.0.0** (March 5, 2021)

* Removed YAML configuration support
* Removed ActiveSupport dependency
* Removed String monkey patch: `to_b` method (to boolean)
* Replaced Travis with GitHub Actions CI
* Added Ruby CI matrix from 2.3 to 3.0

**3.0.0** (July 19, 2017)

* Dropped old Ruby support, now requires Ruby 2.3 and up
* Dropped Travis build for Rails 4.0
* Added support for re-authenticating ([#20](https://github.com/javierjulio/salesforce_bulk/pull/20))
* Use the right tag name for total batches in job info ([#19](https://github.com/javierjulio/salesforce_bulk/pull/19))

**2.0.2** (February 20, 2017)

* Rails 5 support by relaxing ActiveSupport dependency ([#18](https://github.com/javierjulio/salesforce_bulk/pull/18))

**2.0.1** (January 24, 2017)

* Bug fix for response handling ([#17](https://github.com/javierjulio/salesforce_bulk/pull/17))

**2.0.0** (April 25, 2015)

* Dropped support for Ruby 1.8 and Ruby 1.9
* Added support for Ruby 2.0, 2.1 and 2.2
* Added support for Rails 4.0, 4.1 an 4.2
* Changed test_helper to avoid requiring test_unit (removed in Ruby 2.2)
* Replaced Test::Unit::TestCase with ActiveSupport::TestCase
* Bumped shoulda and losen dependencies on minitest
* All changes in PR's #13, #14, #15, #16 - thanks [@pschambacher](https://github.com/pschambacher)

**1.4.0** (June 1, 2014)

* Added state_message to Batch class (#11 - thanks [@bethesque](https://github.com/bethesque))

**1.3.0** (April 28, 2014)

* Added support for multiple subdomains (#10 - thanks [@lucianapazos](https://github.com/lucianapazos))
* Added dependency version requirements to gemspec

**1.2.0** (October 10, 2012)

* Added Ruby 1.8.7 support (thanks [@dlee](https://github.com/dlee))

**1.1.0** (August 20, 2012)

* Added travis setup. Support for Ruby 1.9.2 and 1.9.3 specified.
* Removed `token` property on Client object. Specify token in `password` field.
* Accepted pull request for 1.9.3 improvements.
* Description updates in README.

**1.0.0** (August 17, 2012)

* Initial public release.
