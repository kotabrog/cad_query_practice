FROM ubuntu:22.04

# ロケールなど基本設定
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

# CQ-editorで必要なOpenGL / X関連ライブラリをインストール
# ※ GUI はlibgl1, libxcb-xinerama0, libxkbcommon-x11-0 などが必要
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    libgl1-mesa-dev \
    libxkbcommon-x11-0 \
    libxcb-xinerama0 \
    && rm -rf /var/lib/apt/lists/*

# Miniconda を /opt/conda にインストール
ENV CONDA_DIR=/opt/conda
RUN curl -LO https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash Miniconda3-latest-Linux-x86_64.sh -b -p $CONDA_DIR && \
    rm Miniconda3-latest-Linux-x86_64.sh

# conda にパスを通す
ENV PATH=$CONDA_DIR/bin:$PATH

# conda本体のアップデート + CadQuery用の環境を作成
RUN conda update -n base -c defaults conda && \
    conda create -n cadquery-env python=3.9 -y

# conda initでbashを初期化
RUN conda init bash

# 以後のRUNコマンドをbashで実行
SHELL ["/bin/bash", "-c"]

# CadQuery + CQ-editor をインストール
RUN conda run -n cadquery-env conda install -y -c conda-forge -c cadquery \
    cadquery cq-editor

# 起動時にcadquery-envを自動有効化する設定
RUN echo "conda activate cadquery-env" >> /root/.bashrc

# デフォルトはログインシェルで起動し、.bashrcを読み込ませる
CMD ["/bin/bash", "--login"]
