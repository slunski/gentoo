# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby23 ruby24 ruby25"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_RECIPE_TEST="rspec3"

RUBY_FAKEGEM_GEMSPEC="gh.gemspec"

inherit ruby-fakegem

DESCRIPTION="multi-layer client for the github api v3"
HOMEPAGE="https://github.com/travis-ci/gh"
SRC_URI="https://github.com/travis-ci/gh/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_bdepend "
	dev-ruby/webmock
"

ruby_add_rdepend "
	>=dev-ruby/addressable-2.4.0:0
	dev-ruby/backports
	>dev-ruby/faraday-0.8
	>dev-ruby/multi_json-1.0
	dev-ruby/net-http-pipeline
"

RDEPEND="${RDEPEND}
	ruby_targets_ruby23? ( >=dev-ruby/net-http-persistent-2.9:0[ruby_targets_ruby23] )
	ruby_targets_ruby24? ( >=dev-ruby/net-http-persistent-2.9:0[ruby_targets_ruby24] )
	ruby_targets_ruby25? ( >=dev-ruby/net-http-persistent-3:3[ruby_targets_ruby25] )
"

all_ruby_prepare() {
	sed -i \
		-e '/addressable/ s/2.4.0/2.4/' \
		-e '/net-http-persistent/ s/~> 2.9/>= 2.9/' \
		-e 's/git ls-files/find/' \
		"${RUBY_FAKEGEM_GEMSPEC}" || die
}