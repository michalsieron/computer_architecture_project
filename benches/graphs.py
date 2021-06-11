import numpy as np
import matplotlib.pyplot as plt

# denormalized,ieee754,double
data_a = np.genfromtxt("add_out.csv", delimiter=",")
data_s = np.genfromtxt("sub_out.csv", delimiter=",")
data_m = np.genfromtxt("mult_out.csv", delimiter=",")

# relative difference

fig1 = plt.figure(figsize=(12, 10), dpi=100)

xa = data_a[:, 2]
ya1 = np.fromiter(((r[2] - r[0]) / r[2] for r in data_a), dtype=float)
plt.scatter(xa, ya1, s=1)

ya2 = np.fromiter(((r[2] - r[1]) / r[2] for r in data_a), dtype=float)
plt.scatter(xa, ya2, s=1)

plt.figlegend(["Zdenormalizowane", "IEEE-754"], loc="upper right", bbox_to_anchor=(0.85, 0.85))
plt.savefig("add_relative.png", bbox_inches="tight")

fig2 = plt.figure(figsize=(12, 10), dpi=100)

xs = data_s[:, 2]
ys1 = np.fromiter(((r[2] - r[0]) / r[2] for r in data_s), dtype=float)
plt.scatter(np.abs(xs), np.abs(ys1), s=1)

ys2 = np.fromiter(((r[2] - r[1]) / r[2] for r in data_s), dtype=float)
plt.scatter(np.abs(xs), np.abs(ys2), s=1)

plt.figlegend(["Zdenormalizowane", "IEEE-754"], loc="upper right", bbox_to_anchor=(0.85, 0.85))
plt.savefig("sub_relative.png", bbox_inches="tight")

fig3 = plt.figure(figsize=(12, 10), dpi=100)

xm = data_m[:, 2]
ym1 = np.fromiter(((r[2] - r[0]) / r[2] for r in data_m), dtype=float)
plt.scatter(xm, ym1, s=1)

ym2 = np.fromiter(((r[2] - r[1]) / r[2] for r in data_m), dtype=float)
plt.scatter(xm, ym2, s=1)

plt.figlegend(["Zdenormalizowane", "IEEE-754"], loc="upper right", bbox_to_anchor=(0.85, 0.85))
plt.savefig("mul_relative.png", bbox_inches="tight")

# absolute (ulp) difference

fig4 = plt.figure(figsize=(12, 10), dpi=100)

xa = data_a[:, 2]
ya1 = np.fromiter((abs(r[2] - r[0]) / 2 ** 24 for r in data_a), dtype=float)
plt.scatter(xa, ya1, s=1)

ya2 = np.fromiter((abs(r[2] - r[1]) / 2 ** 24 for r in data_a), dtype=float)
plt.scatter(xa, ya2, s=1)

plt.figlegend(["Zdenormalizowane", "IEEE-754"], loc="upper left", bbox_to_anchor=(0.15, 0.85))
plt.savefig("add_ulp.png", bbox_inches="tight")

fig5 = plt.figure(figsize=(12, 10), dpi=100)

xs = data_s[:, 2]
ys1 = np.fromiter((abs(r[2] - r[0]) / 2 ** 24 for r in data_s), dtype=float)
plt.scatter(np.abs(xs), np.abs(ys1), s=1)

ys2 = np.fromiter((abs(r[2] - r[1]) / 2 ** 24 for r in data_s), dtype=float)
plt.scatter(np.abs(xs), np.abs(ys2), s=1)

plt.figlegend(["Zdenormalizowane", "IEEE-754"], loc="upper left", bbox_to_anchor=(0.15, 0.85))
plt.savefig("sub_ulp.png", bbox_inches="tight")

fig6 = plt.figure(figsize=(12, 10), dpi=100)

xm = data_m[:, 2]
ym1 = np.fromiter((abs(r[2] - r[0]) / 2 ** 24 for r in data_m), dtype=float)
plt.scatter(xm, ym1, s=1)

ym2 = np.fromiter((abs(r[2] - r[1]) / 2 ** 24 for r in data_m), dtype=float)
plt.scatter(xm, ym2, s=1)

plt.figlegend(["Zdenormalizowane", "IEEE-754"], loc="upper left", bbox_to_anchor=(0.15, 0.85))
plt.savefig("mul_ulp.png", bbox_inches="tight")

# plt.show()
