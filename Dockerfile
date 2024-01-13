FROM buildpack-deps:bookworm-scm

# インストール構成をコピー
COPY texlive.profile /tmp/texlive-install/

# texliveをインストール
RUN cd /tmp/texlive-install && \
  wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
  tar -xvf install-tl-unx.tar.gz && \
  perl ./install-tl-2*/install-tl --no-interaction -profile texlive.profile && \
  ln -sf /usr/local/texlive/2023/bin/$(uname -m)-linux /usr/local/texlive/bin && \
  rm -rf /tmp/texlive-install/

# texliveにパスを通す
ENV PATH="/usr/local/texlive/bin:$PATH"

# 追加パッケージをインストール
RUN tlmgr update --self --all && \
  tlmgr install latexmk collection-mathscience collection-latexextra
