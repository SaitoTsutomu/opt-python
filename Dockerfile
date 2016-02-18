FROM ubuntu-debootstrap:14.04

ENV PATH=/opt/conda/bin:$PATH \
    LANG=C.UTF-8 \
    MINICONDA=Miniconda3-latest-Linux-x86_64.sh \
    DEBIAN_FRONTEND=noninteractive \
    FNCD=FuncDesigner-0.5620
COPY dif1 dif2 dif3 /root/
RUN apt-get update --fix-missing && apt-get install -y \
    libglib2.0-0 libxext6 libsm6 libxrender1 gcc \
    ca-certificates busybox wget fonts-ipaexfont && \
    /bin/busybox --install && \
    apt-get clean && \
    echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget -q https://repo.continuum.io/miniconda/$MINICONDA \
            https://github.com/ipython-contrib/IPython-notebook-extensions/archive/master.zip \
            https://raw.githubusercontent.com/Tsutomu-KKE/scientific-python/master/notebook.json && \
    bash /$MINICONDA -b -p /opt/conda && \
    conda update -y conda && \
    conda install -y nomkl matplotlib networkx scikit-learn jupyter blist bokeh blaze \
                  statsmodels ncurses seaborn dask flask markdown sympy && \
    pip install pulp pyjade more-itertools && \
    ln -s /usr/share/fonts/opentype/ipaexfont-gothic/ipaexg.ttf \
        /opt/conda/lib/python3.5/site-packages/matplotlib/mpl-data/fonts/ttf/ && \
    unzip -q master.zip && \
    mkdir -p /root/.local/share/jupyter /root/.jupyter/nbconfig && \
    mv notebook.json /root/.jupyter/nbconfig/ && \
    cd IPython-notebook-extensions-master && \
    python setup.py install && \
    cd /root && \
    wget -q https://pypi.python.org/packages/source/F/FuncDesigner/"$FNCD".tar.gz && \
    tar zxf "$FNCD".tar.gz && \
    cd $FNCD/FuncDesigner && patch -u translator.py < ~/dif1 && \
    cd examples && patch -u lp2.py < ~/dif2 && cd ../.. && \
    python setup.py install && \
    pip install openopt mypulp myopenopt && \
    cd /opt/conda/lib/python3.?/site-packages/matplotlib/mpl-data && \
    patch -u matplotlibrc < ~/dif3 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /$MINICONDA /IPython-notebook-extensions-master \
           /master.zip /root/* /root/.c* /opt/conda/pkgs/*
CMD ["/bin/bash"]
