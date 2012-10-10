//----------------------------  system_1.cc  ---------------------------
//    system_1.cc,v 1.3 2003/06/09 21:55:00 wolf Exp
//    Version: 
//
//    Copyright (C) 2003, 2005 by the deal.II authors
//
//    This file is subject to QPL and may not be  distributed
//    without copyright and license information. Please refer
//    to the file deal.II/doc/license.html for the  text  and
//    fuqher information on this license.
//
//----------------------------  system_1.cc  ---------------------------


// check what happens with an FE_System if we hand it 0 components

#include "../tests.h"
#include <deal.II/base/logstream.h>
#include <deal.II/fe/fe_q.h>
#include <deal.II/fe/fe_dgq.h>
#include <deal.II/fe/fe_dgp.h>
#include <deal.II/fe/fe_system.h>
#include <deal.II/fe/fe_tools.h>

#include <fstream>
#include <string>

#define PRECISION 5



template<int dim>
void
check(FESystem<dim> &fe)
{
  deallog << fe.get_name() << std::endl;
  deallog << "components: " << fe.n_components() << std::endl;
  deallog << "blocks: " << fe.n_blocks() << std::endl;
  deallog << "conforms H1: " << fe.conforms(FiniteElementData<dim>::H1) << std::endl;
  deallog << "n_base_elements: " << fe.n_base_elements() << std::endl;
}

int
main()
{
  std::ofstream logfile ("system_02/output");
  deallog << std::setprecision(PRECISION);
  deallog << std::fixed;  
  deallog.attach(logfile);
  deallog.depth_console(0);
  deallog.threshold_double(1.e-10);

  {
    FESystem<2> fe(FE_Q<2>(1), 2, FE_Q<2>(1), 1);
    check<2>(fe);
  }
  {
    FESystem<2> fe(FE_Q<2>(1), 2, FE_DGQ<2>(2),0, FE_Q<2>(1), 1);
    check<2>(fe);
  }
  {
    FESystem<2> fe(FESystem<2>(FE_Q<2>(1), 2), 1, FE_Q<2>(1), 1);
    check<2>(fe);
  }
  {
    FESystem<2> fe(FESystem<2>(FE_Q<2>(1), 2), 1, FE_DGQ<2>(2),0, FE_Q<2>(1), 1);
    check<2>(fe);
  }
  
  return 0;
}


