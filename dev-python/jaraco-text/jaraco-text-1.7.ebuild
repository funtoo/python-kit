# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit distutils-r1

MY_PN="${PN/-/.}"
DESCRIPTION="Text utilities used by other projects by developer jaraco"
HOMEPAGE="https://github.com/jaraco/jaraco.text"
SRC_URI="mirror://pypi/${PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

PDEPEND="dev-python/jaraco-collections[${PYTHON_USEDEP}]"
RDEPEND="dev-python/jaraco-functools[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/setuptools_scm-1.9[${PYTHON_USEDEP}]
	doc? (
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/rst-linker[${PYTHON_USEDEP}]
	)
	test? (
		${RDEPEND}
		>=dev-python/pytest-2.8[${PYTHON_USEDEP}]
		dev-python/pytest-runner[${PYTHON_USEDEP}]
	)
"

S="${WORKDIR}/${MY_PN}-${PV}"

python_compile_all() {
	use doc && esetup.py build_sphinx
}

python_test() {
	PYTHONPATH=. py.test || die "tests failed with ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( "${BUILD_DIR}"/sphinx/html/. )
	distutils-r1_python_install_all
}
