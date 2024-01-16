package=randomx
$(package)_version=0.1.0
$(package)_download_path=https://github.com/bitwealth-network/ProofOfWorkCPU/archive/refs/tags
$(package)_file_name=v$($(package)_version).tar.gz
$(package)_sha256_hash=50ad635f95b7a02942222a232423e6ba3adab2b7f20eb74f773d78968439437c

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
