FROM tsutomu7/scientific-python

ENV DEBIAN_FRONTEND=noninteractive \
    FNCD=FuncDesigner-0.5620
COPY dif1 dif2 dif3 /root/
RUN apt-get update --fix-missing && apt-get install -y gcc patch \
    apt-get clean && \
    wget -q --no-check-certificate \
        https://pypi.python.org/packages/source/F/FuncDesigner/"$FNCD".tar.gz && \
    tar zxf "$FNCD".tar.gz && cd $FNCD/FuncDesigner && \
    patch -u translator.py < ~/dif1 && cd examples && \
    patch -u lp2.py < ~/dif2 && cd ../.. && \
    python setup.py install && \
    pip install openopt mypulp myopenopt && \
    cd /opt/conda/lib/python3.5/site-packages/matplotlib/mpl-data && \
    patch -u matplotlibrc < ~/dif3 && \
    rm -rf /var/lib/apt/lists/* /root/* /root/.c*
CMD ["/bin/bash"]
