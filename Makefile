F90 = ifort
#F90 = f90
#F90 = pf90
#LDR     = $(F90)

# F90 options
F90FLAGS = -O3 -u -fpe0 -vec_report -ipo #Lobster 6
#F90FLAGS = -O4 -omp -fpe1# -fpe4 Compaq
#F90FLAGS  = -O3 -openmp

#F90FLAGS = -g -O0 -openmp #seg fault
#F90FLAGS = -g -O0 
#F90FLAGS = -u -fpe0
#F90FLAGS = -O3 -u -ipo -fpe0
#F90FLAGS = -O3 -ipo
#F90FLAGS = -fpe0 -g -u 
#F90FLAGS = -O3 -vec_report -u -ipo
#F90FLAGS = -xW -O3 -openmp -vec_report -u -ipo -fpe0
#F90FLAGS =  -Wv,-Pprocs,4 -O3 -cpu:opteron

OPTIONS = $(F90FLAGS)

LDFLAGS = $(OPTIONS)
LIBS = 

.f.o:
	$(F90) -c $(OPTIONS) $<

.f90.o:
	$(F90) -c $(OPTIONS) $<

.F90.o:
	$(F90) -c $(OPTIONS) $<

f.mod:
	$(F90) -c $(OPTIONS) $<

.SUFFIXES: .f90 .F90 .mod .o

UTILS=mrgrnk.o ctrper.o romberg.o

CONSTANTS = mathconstants.o cgsconstants.o  cgsphotoconstants.o  cgsastroconstants.o c2ray_parameters.o cosmoparms.o sizes.o abundances.o

C2Ray_3D_BigBox_periodic: precision.o $(CONSTANTS) $(UTILS) no_mpi.o file_admin.o pmfast.o grid.o tped.o mat_ini_BigBox.o sourceprops.o cooling.o radiation.o cosmology.o clumping.o time_ini.o doric.o photonstatistics.o evolve4_omp_periodic.o output.o C2Ray.o
	$(F90) $(OPTIONS) -o $@ precision.o $(UTILS) no_mpi.o file_admin.o pmfast.o grid.o tped.o mat_ini_BigBox.o sourceprops.o cooling.o radiation.o cosmology.o clumping.o cooling.o time_ini.o doric.o photonstatistics.o evolve4_omp_periodic.o output.o C2Ray.o

clean : 
	rm -f *.o *.mod *.l *.il
