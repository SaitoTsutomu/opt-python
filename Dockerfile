FROM scientific-python-3.5

RUN apt-get update --fix-missing && apt-get install -y gcc && \
    wget https://pypi.python.org/packages/source/F/FuncDesigner/FuncDesigner-0.5620.tar.gz && \
    tar zxf FuncDesigner-0.5620.tar.gz && \
    cd FuncDesigner-0.5620/FuncDesigner && patch -u translator.py < /dif1 && \
    cd examples && patch -u lp2.py < /dif2 & cd ../.. && \
    python setup.py install && \
    pip install -U pip && pip install openopt mypulp myopenopt && \
    apt-get clean && \
    rm -rf /FuncDesigner-0.5620* /var/lib/apt/lists/* /root/.c* /opt/conda/pkgs/*
CMD ["/bin/bash"]
