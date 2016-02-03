FROM tsutomu7/scientific-python-3.5

COPY dif1 dif2 /root/
RUN apt-get update --fix-missing && apt-get install -y gcc && cd /root && \
    wget https://pypi.python.org/packages/source/F/FuncDesigner/FuncDesigner-0.5620.tar.gz && \
    tar zxf FuncDesigner-0.5620.tar.gz && \
    cd FuncDesigner-0.5620/FuncDesigner && patch -u translator.py < ~/dif1 && \
    cd examples && patch -u lp2.py < ~/dif2 && cd ../.. && \
    python setup.py install && \
    pip install -U pip && pip install openopt mypulp myopenopt && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /root/* /root/.c* /opt/conda/pkgs/*
CMD ["/bin/bash"]
