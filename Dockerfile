FROM tsutomu7/scientific-python

ENV DEBIAN_FRONTEND=noninteractive \
    FNCD=FuncDesigner-0.5620
RUN sudo apt-get update --fix-missing && sudo apt-get install -y gcc patch && \
    sudo apt-get clean && \
    wget -q --no-check-certificate \
        https://pypi.python.org/packages/source/F/FuncDesigner/"$FNCD".tar.gz && \
    tar zxf "$FNCD".tar.gz && \
    sed -i 's/r = ooPoint((v, x\[S.oovar_indexes\[i]:S.oovar_indexes\[i+1]]) for i, v in enumerate(S._variables), \*\*kw)/r = ooPoint([(v, x[S.oovar_indexes[i]:S.oovar_indexes[i+1]]) for i, v in enumerate(S._variables)], **kw)/' ~/$FNCD/FuncDesigner/translator.py && \
    sed -i 's/print f(point) /print(f(point)) /' ~/$FNCD/FuncDesigner/examples/lp2.py && \
    sed -i 's/#font.family         : sans-serif/font.family         : IPAexGothic/' /opt/conda/lib/python3.5/site-packages/matplotlib/mpl-data/matplotlibrc && \
    cd $FNCD && \
    python setup.py install && \
    pip install openopt mypulp myopenopt && \
    sudo apt-get purge -y --auto-remove gcc patch && \
    sudo rm -rf /var/lib/apt/lists/* ~/.cache ~/FuncDesigner*
CMD ["/bin/bash"]
