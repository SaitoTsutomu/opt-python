FROM tsutomu7/scientific-python

COPY dif1 dif2 dif3 /root/
RUN apt-get update --fix-missing && \
    apt-get install -y gcc-4.8-base libc6 libstdc++6 && apt-get install -y gcc && cd /root && \
    wget -q https://pypi.python.org/packages/source/F/FuncDesigner/FuncDesigner-0.5620.tar.gz && \
    tar zxf FuncDesigner-0.5620.tar.gz && \
    cd FuncDesigner-0.5620/FuncDesigner && patch -u translator.py < ~/dif1 && \
    cd examples && patch -u lp2.py < ~/dif2 && cd ../.. && \
    python setup.py install && \
    pip install openopt mypulp myopenopt && \
    cd /opt/conda/lib/python3.5/site-packages/matplotlib/mpl-data && \
    patch -u matplotlibrc < ~/dif3 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /root/* /root/.c* /opt/conda/pkgs/*
CMD ["/bin/bash"]
