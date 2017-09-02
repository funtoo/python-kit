# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
# Not quite ready for py3, unconditionally deps on too many backported
# pkgs installed in newer pythons that shouldn't need them.
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

MY_PV="17.6.1.post3"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Crossbar.io - The Unified Application Router for the twisted framework"
HOMEPAGE="http://crossbar.io/ https://github.com/crossbario/crossbar https://pypi.python.org/pypi/crossbar"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${MY_P}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="
	>=dev-python/setuptools-36.0.1[${PYTHON_USEDEP}]
	>=dev-python/twisted-17.5.0[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '>=dev-python/enum34-1.1.6[${PYTHON_USEDEP}]' python2_7)
	>=dev-python/txaio-2.8.0[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-0.2.3[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-modules-0.0.9[${PYTHON_USEDEP}]
	>=dev-python/incremental-17.5.0[${PYTHON_USEDEP}]
	>=dev-python/zope-interface-4.4.2[${PYTHON_USEDEP}]
	<dev-python/hyper-h2-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/priority-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/service_identity-17.0.0[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-17.1.0[${PYTHON_USEDEP}]
	>=dev-python/cryptography-1.9.0[${PYTHON_USEDEP}]
	>=dev-python/autobahn-17.6.2[${PYTHON_USEDEP}]
	>=dev-python/jinja-2.9.6[${PYTHON_USEDEP}]
	>=dev-python/treq-17.3.1[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.12[${PYTHON_USEDEP}]
	>=dev-python/click-6.7[${PYTHON_USEDEP}]
	>=dev-python/attrs-17.2.0[${PYTHON_USEDEP}]
	>=dev-python/constantly-15.1.0[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '>=dev-python/ipaddress-1.0.18[${PYTHON_USEDEP}]' python2_7)
	>=dev-python/cbor-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/bitstring-3.1.5[${PYTHON_USEDEP}]
	>=dev-python/pygments-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/pytrie-0.3[${PYTHON_USEDEP}]
	>=dev-python/psutil-5.2.2[${PYTHON_USEDEP}]
	>=dev-python/py-ubjson-0.9.0[${PYTHON_USEDEP}]
	>=dev-python/pynacl-1.1.2[${PYTHON_USEDEP}]
	>=dev-python/pyqrcode-1.2.1[${PYTHON_USEDEP}]
	>=dev-python/lmdb-0.92[${PYTHON_USEDEP}]
	>=dev-python/mistune-0.7.4[${PYTHON_USEDEP}]
	>=dev-python/netaddr-0.7.19[${PYTHON_USEDEP}]
	>=dev-python/setproctitle-1.1.10[${PYTHON_USEDEP}]
	>=dev-python/sdnotify-0.3.1[${PYTHON_USEDEP}]
	>=dev-python/shutilwhich-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/u-msgpack-2.4.1[${PYTHON_USEDEP}]
	>=dev-python/watchdog-0.8.3[${PYTHON_USEDEP}]
"
DEPEND="
	>=dev-python/setuptools-36.0.1[${PYTHON_USEDEP}]
	>=dev-python/twisted-17.5.0[${PYTHON_USEDEP}]
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
	)
"
DOCS=(
	README.rst LICENSE-FOR-API LICENSE COPYRIGHT
)

S="${WORKDIR}"/${MY_P}

python_prepare_all() {
	# don't install the copyright, license... let dodoc do it
	sed -e "s/^    data_files=.*//" -i setup.py || die

	distutils-r1_python_prepare_all
}
