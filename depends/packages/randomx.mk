package=randomx
$(package)_version=0.1.0
$(package)_download_path=https://github.com/imnotsatosh/BtbPow/archive/refs/tags
$(package)_file_name=v$($(package)_version).tar.gz
$(package)_sha256_hash=1955e235b14779b69a9ef8e0e08478e036f19f0ebe96eda2ffcc1815d5aad849

define $(package)_preprocess_cmds
	cp -f $(BASEDIR)/config.guess $(BASEDIR)/config.sub . 
endef

define $(package)_config_cmds
	cmake -DARCH=native .
endef

define $(package)_build_cmds
	$(MAKE)
endef

define $(package)_stage_cmds
	mkdir -p $($(package)_staging_prefix_dir)/include $($(package)_staging_prefix_dir)/lib &&\
	install ./src/*.h $($(package)_staging_prefix_dir)/include &&\
	install librandomx.a $($(package)_staging_prefix_dir)/lib
endef

# define $(package)_postprocess_cmds
#   rm lib/*.la
# endef
