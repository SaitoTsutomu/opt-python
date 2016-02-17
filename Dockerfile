FROM tsutomu7/scientific-python

COPY dif1 dif2 dif3 /root/
ENV DEBIAN_FRONTEND=noninteractive \
    FNCD=FuncDesigner-0.5620
RUN apt-get update --fix-missing && apt-get install -y gcc && cd /root && \
    wget -q https://pypi.python.org/packages/source/F/FuncDesigner/"$FNCD".tar.gz && \
    tar zxf "$FNCD".tar.gz && \
    cd $FNCD/FuncDesigner && patch -u translator.py < ~/dif1 && \
    cd examples && patch -u lp2.py < ~/dif2 && cd ../.. && \
    python setup.py install && \
    pip install openopt mypulp myopenopt && \
    cd /opt/conda/lib/python3.?/site-packages/matplotlib/mpl-data && \
    patch -u matplotlibrc < ~/dif3 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /root/* /root/.c* /opt/conda/pkgs/*
CMD ["/bin/bash"]
