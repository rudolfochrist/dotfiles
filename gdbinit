define phead
       set $ptr = $arg1
       plistdata $arg0
end
document phead
Print first element of a list.
Usage:
  Glist *datalist  /* GLib */
  g_list_add(datalist, "Hello")

gdb> phead char datalist
gdb> pnext char
gdb> pnext char

This macro sets $ptr as the current element and sets $pdata as it's data.
This macro works with every linked list  that has a `next` and a `data` item.
end

define pnext
       set $ptr->next
       plistdata $arg0
end
document pnext
Sets $ptr to the next list element.
end

define plistdata
       if $ptr
          set $pdata = $ptr->data
       else
          set $pdata = 0
       end

       if $pdata
          p ($arg0*) $pdata
       else
          p "NULL"
       end
end
document plistdata
This macro used by phead and pnext sets $pdata accordingly.
Don't use this directly.
end
