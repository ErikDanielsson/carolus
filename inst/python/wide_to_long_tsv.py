import gzip
import pandas as pd
import tempfile
import sys
import shutil
import logging

from pathlib import Path

logger = logging.getLogger(__name__)
logging.basicConfig(stream=sys.stderr, level=logging.INFO)


def wide_to_long_tsv(
    in_fn, out_fn, id_header_name, col_header_name, val_header_name, chunksize=10000
):
    in_fn = Path(in_fn)
    out_fn = Path(out_fn)

    # Read compressed input in chunks
    wide_iter = pd.read_csv(
        in_fn,
        chunksize=chunksize,
        compression="gzip" if in_fn.suffix == ".gz" else None,
        sep="\t",
    )

    tmp_fn = tempfile.mktemp()
    logger.info(f"Writing chunks ({chunksize} lines per chunk) to tmpfile {tmp_fn}:")
    print_freq = 10
    for i, chunk in enumerate(wide_iter):
        if i % print_freq == 0:
            logger.info(
                f"Chunk {i}-{i + print_freq - 1} (lines {chunksize * i}-{chunksize * (i + print_freq) - 1})"
            )
        # Reshape wide -> long
        long_chunk = chunk.melt(
            id_vars=[id_header_name],
            var_name=col_header_name,
            value_name=val_header_name,
        )
        long_chunk = long_chunk[long_chunk[val_header_name] > 0]

        # Write out incrementally (plain CSV)
        if i == 0:
            long_chunk.to_csv(tmp_fn, index=False, mode="w", sep="\t")
        else:
            long_chunk.to_csv(tmp_fn, index=False, header=False, mode="a", sep="\t")
    if out_fn.suffix == ".gz":
        logger.info(f"Copying contents from temp file {tmp_fn} and gzipping at {out_fn}")
        with open(tmp_fn, "rb") as rh, gzip.open(out_fn, "wb") as wh:
            wh.writelines(rh)
    else:
        logger.info(f"Moving temp file {tmp_fn} to final destination {out_fn}")
        shutil.move(tmp_fn, out_fn)
