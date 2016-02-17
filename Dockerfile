FROM tsutomu7/alpine-python

COPY dif1 dif2 dif3 /root/
RUN apk add --no-cache libstdc++ && \
    apk add --no-cache --virtual=build-dependencies musl-dev gcc wget && \
    ln -s /usr/include/sys/ /usr/include/linux && cd /root && \
    wget -q --no-check-certificate https://pypi.python.org/packages/source/F/FuncDesigner/FuncDesigner-0.5620.tar.gz && \
    tar zxf FuncDesigner-0.5620.tar.gz && cd FuncDesigner-0.5620/FuncDesigner && \
    patch -u translator.py < ~/dif1 && cd examples && \
    patch -u lp2.py < ~/dif2 && cd ../.. && \
    python setup.py install && \
    pip install openopt mypulp myopenopt && \
    cd /opt/conda/lib/python3.5/site-packages/matplotlib/mpl-data && \
    patch -u matplotlibrc < ~/dif3 && \
    apk del build-dependencies && \
    rm -rf /root/* /root/.c*
CMD ["sh"]
