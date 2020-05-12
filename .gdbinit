python
import sys
sys.path.insert(0, '.')
from printers import register_str_printers
register_str_printers (gdb.current_objfile())
end
