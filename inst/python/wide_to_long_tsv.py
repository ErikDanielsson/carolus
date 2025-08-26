import gzip
from pathlib import Path

def wide_to_long_tsv(in_fn, out_fn, col_header_name, val_header_name):
    in_fn = Path(in_fn)
    out_fn = Path(out_fn)

    open_read_func = gzip.open if in_fn.suffix == ".gz" else open
    open_write_func = gzip.open if out_fn.suffix == ".gz" else open
    with open_read_func(in_fn, "rt") as fh, open_write_func(out_fn, "wt") as oh:
        header = next(fh).split("\t")
        new_header = [header[0], col_header_name, val_header_name]
        sample_names = header[1:]
        oh.write("\t".join(new_header) + "\n") 
        for i, line in enumerate(fh):
            if i % 100000 == 0:
                print(i)
            cols = line.split("\t") 
            asv = cols[0] 
            samples = filter(lambda x: x[1] > "0", zip(sample_names, cols[1:]))
            for sname, counts in samples:
                oh.write(f"{asv}\t{sname}\t{counts}\n")
