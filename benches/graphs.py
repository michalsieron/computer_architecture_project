import numpy as np
import matplotlib.pyplot as plt

# denormalized,ieee754,double
data_a = np.genfromtxt("add_out.csv", delimiter=",")
data_s = np.genfromtxt("sub_out.csv", delimiter=",")
data_m = np.genfromtxt("mult_out.csv", delimiter=",")


fig, ax = plt.subplots(2, 3)

# relative difference

xa = data_a[:, 2]
ax[0, 0].set_title("Add relative")
ya1 = np.fromiter(((r[2] - r[0]) / r[2] for r in data_a), dtype=float)
ax[0, 0].scatter(xa, ya1, s=1)

ya2 = np.fromiter(((r[2] - r[1]) / r[2] for r in data_a), dtype=float)
ax[0, 0].scatter(xa, ya2, s=1)

xs = data_s[:, 2]
ax[0, 1].set_title("Subtract relative")
ys1 = np.fromiter(((r[2] - r[0]) / r[2] for r in data_s), dtype=float)
ax[0, 1].scatter(np.abs(xs), ys1, s=1)

ys2 = np.fromiter(((r[2] - r[1]) / r[2] for r in data_s), dtype=float)
ax[0, 1].scatter(np.abs(xs), ys2, s=1)

xm = data_m[:, 2]
ax[0, 2].set_title("Multiply relative")
ym1 = np.fromiter(((r[2] - r[0]) / r[2] for r in data_m), dtype=float)
ax[0, 2].scatter(xm, ym1, s=1)

ym2 = np.fromiter(((r[2] - r[1]) / r[2] for r in data_m), dtype=float)
ax[0, 2].scatter(xm, ym2, s=1)

# absolute (ulp) difference

xa = data_a[:, 2]
ax[1, 0].set_title("Add ULP")
ya1 = np.fromiter((abs(r[2] - r[0]) / 2 ** 24 for r in data_a), dtype=float)
ax[1, 0].scatter(xa, ya1, s=1)

ya2 = np.fromiter((abs(r[2] - r[1]) / 2 ** 24 for r in data_a), dtype=float)
ax[1, 0].scatter(xa, ya2, s=1)

xs = data_s[:, 2]
ax[1, 1].set_title("Subtract ULP")
ys1 = np.fromiter((abs(r[2] - r[0]) / 2 ** 24 for r in data_s), dtype=float)
ax[1, 1].scatter(np.abs(xs), ys1, s=1)

ys2 = np.fromiter((abs(r[2] - r[1]) / 2 ** 24 for r in data_s), dtype=float)
ax[1, 1].scatter(np.abs(xs), ys2, s=1)

xm = data_m[:, 2]
ax[1, 2].set_title("Multiply ULP")
ym1 = np.fromiter((abs(r[2] - r[0]) / 2 ** 24 for r in data_m), dtype=float)
ax[1, 2].scatter(xm, ym1, s=1)

ym2 = np.fromiter((abs(r[2] - r[1]) / 2 ** 24 for r in data_m), dtype=float)
ax[1, 2].scatter(xm, ym2, s=1)

fig.tight_layout()
plt.figlegend(["Denormalized", "IEEE 754"], loc="lower center", ncol=2)
plt.show()
