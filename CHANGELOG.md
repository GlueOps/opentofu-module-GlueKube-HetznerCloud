# Changelog

## [1.7.0](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/compare/v1.6.4...v1.7.0) (2026-07-07)


### Features

* add 'attached' variable to node pool configuration ([#37](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/issues/37)) ([fab5fa2](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/commit/fab5fa2ef7f0bf3bec927a852cc0309a1b8c0839))
* add autoglue gluekube integration ([8d7cca4](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/commit/8d7cca492d5a30cda1c42eccd55a479723ffaadf))
* add icmp to servers ([#21](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/issues/21)) ([34ff6d2](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/commit/34ff6d2debcca0fcedefa617a42c3339da648531))
* add service and calico CIDR metadata resources and validation for CIDR variables ([5d72677](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/commit/5d726777a7c539652fc2633aa129fd60e1e76760))
* add support for Kubernetes annotations in node pool configuration ([#33](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/issues/33)) ([2840f09](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/commit/2840f097d919d1783d7bc6d70f31be15a8c7fba0))
* added cluster metadata ([5f40c0b](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/commit/5f40c0b88c845a20a61c06ef790d0736b7f56d55))
* added lifecycle changes ([0697417](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/commit/069741728018c90621032fae266f7212da270c61))
* adding consistency and standardization ([#58](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/issues/58)) ([5134c28](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/commit/5134c28dd38c61409c0d5a7785d052a753c70de8))
* adding helm docs workflows ([#17](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/issues/17)) ([0a36f2e](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/commit/0a36f2e7c599855d8e2d15ce5fa24aec77740204))
* consolidate cloud-init configurations and remove deprecated files ([b9c81c0](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/commit/b9c81c0ef883cbb80b12da3248e535262b9b6fe6))
* disable IPv6 support and add configuration option for node pools ([0d3d5bc](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/commit/0d3d5bcf733c6365405d6a2276184e569b96863d))
* disable IPv6 support and add configuration option for node pools ([#48](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/issues/48)) ([5985694](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/commit/59856945476be0246ee1eb11731cb6224772f07e))
* fix missing resources ([#14](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/issues/14)) ([565f589](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/commit/565f5890cc3177ea24bff1b6d1855d82823d0aa9))
* Module integration ([#10](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/issues/10)) ([992c54b](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/commit/992c54bfa134b0bee56605101a358bf1c5ed58c1))
* pin hc-utils to 0.0.6 for assigning private ip ([782561d](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/commit/782561d3c787ed015a18d2105c7474522630574d))
* remove terraform folder ([7793236](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/commit/7793236ab630f0b334ef4526a2e148c554eb0260))
* remove unnecessary rp_filter settings from sysctl configuration ([4462fc7](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/commit/4462fc7ba9e720037f84b8173373be36ed00c5b6))
* Remove validation for master node pool count ([d9ea985](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/commit/d9ea985b60d56396e23eee85b314e2f310d0e975))
* specify version for cluster_metadata module source ([cfc0bc7](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/commit/cfc0bc7cecf66b69f58dd9c5f2c6b31865b51565))
* updated node pool name to avoid conflict ([#19](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/issues/19)) ([0c9a59e](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/commit/0c9a59e043f420c5754f84d290e5e4eda6ef6b76))


### Bug Fixes

* added gluekube image and tags as variables ([b6861c8](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/commit/b6861c8068ae17df0d8d807a69e4cdb9bdc83bba))
* change aws creds to route53 to avoid future conflicts and maintain consistency ([cc0eaea](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/commit/cc0eaeaae9aa3594ee4b8bffe0a7257fe161bcdb))
* change hostname ([1f40c19](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/commit/1f40c19a2985bc1da02fd0c85e52eb19ba446f52))
* created few variable for readiblity ([00bb8fe](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/commit/00bb8fea2f14c17fcfae3b5b35c3f1eeb8d00fce))
* Delete .github/workflows/container_image.yaml ([#16](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/issues/16)) ([e40e0b6](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/commit/e40e0b6cdd69bb3e8b231a6e383bd9b2a14c80c7))
* netplan for fixing the private network interface ([b701302](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/commit/b7013028554d32e1cdb3a55a030497daf40241bf))
* readme ([5783a5a](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/commit/5783a5ac0056f4d454ef6f6f3a81a0554f49d668))
* refactored ([d74d0e8](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/commit/d74d0e8fcc81a6b729c6c5eee62baf9d8b28bf52))
* Update domain ID reference in cluster.tf ([#15](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/issues/15)) ([f8c5b0b](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/commit/f8c5b0bcb19624a4c27f5282db2e5cec5755c861))


### Miscellaneous Chores

* **patch:** update autoglue to 0.10.5 #patch ([#28](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/issues/28)) ([0cb7633](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/commit/0cb7633e02e87f49443ce796a2a0adcab5618c47))
* **patch:** update autoglue to 0.10.6 #patch ([#32](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/issues/32)) ([b8b9f00](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/commit/b8b9f00199d2860e96cf4e411072fb2ba9e5e3fd))
* Update autoglue provider version to 0.10.6 ([#31](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/issues/31)) ([02a3919](https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud/commit/02a39196d3fd398612565b8459dce48ddc124130))
