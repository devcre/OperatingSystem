#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/list.h>
#include <linux/module.h>
#include <linux/slab.h>

struct birthday {
  int day;
  int month;
  int year;
  struct list_head list;
};

static LIST_HEAD(birthday_list);

struct birthday *createBirthday(int day, int month, int year) {
		struct birthday *new_birthday;
		new_birthday = kmalloc(sizeof(new_birthday), GFP_KERNEL);

		//new_birthday.day = day;
		//new_birthday.month = month;
		//new_birthday.year = year;
		//new_birthday.list -> prev = NULL;
		//new_birthday.list -> next = NULL;

		new_birthday -> day = day;
		new_birthday -> month = month;
		new_birthday -> year = year;
		//((*new_birthday).list).prev = NULL;
		//((*new_birthday).list).next = NULL;

		return new_birthday;

  /* TODO: 생일을 위한 메모리를 할당하고, 인자들을 채워 생일을 완성하세요. */

}

int simple_init(void) {
		//Create Node and add to birthday_list
	struct birthday *Node_one = createBirthday(21, 3, 1995);
	list_add_tail(&Node_one->list, &birthday_list);
	struct birthday *Node_two = createBirthday(5, 5, 1997);
	list_add_tail(&Node_two->list, &birthday_list);
	struct birthday *Node_three = createBirthday(17, 8, 1999);
	list_add_tail(&Node_three->list, &birthday_list);

  /* TODO: 생일 목록을 하나씩 생성하는대로 연결리스트에 연결시키세요(노드 삽입). */

  /* TODO: 완성된 연결리스트를 탐색하는 커널 함수를 사용하여 출력하세요. */

	struct birthday *cursor;
	list_for_each_entry(cursor, &birthday_list, list){
		printk("Day %d.%d.%d\n", cursor -> day, cursor -> month, cursor -> year);
	}

  return 0;
}

void simple_exit(void) {
  /* 모듈을 제거할 때는 생성한 연결 리스트도 하나씩 제거하며 끝내도록 하세요. */
  /* 제거를 하기 전에 리스트가 "비어있을 경우""에 대한 예외처리를 하는게 좋겠죠? */
    if(list_empty(&birthday_list)) {
        printk("List is Empty\n");
        return;
    }

  /* TODO: 이제 본격적으로 연결리스트를 탐색하면서 하나씩 제거하도록 하시면 됩니다. */
  /* 다만, 제거를 하면서 연결리스트를 탐색하면 문제가 생길 것 같은데 어떤 방법으로 해결 가능한지 생각해보세요. */

    struct birthday *cursor_node;
    struct list_head *cursor, *next;
    list_for_each_safe(cursor, next, &birthday_list){
    	cursor_node = list_entry(cursor, struct birthday, list);

    	printk("DEL NODE DATA: %d.%d.%d\n", cursor_node->day, cursor_node->month, cursor_node->year);
    	list_del(cursor);
    	kfree(cursor_node);
    }
    // delete node but cannot print
/*	struct list_head *ptr, *next;
	list_for_each_safe(ptr, next, &birthday_list){
		printk("Removing %d.%d.%d\n", ptr->day, ptr->month, ptr->year);

		list_del(ptr);
		kfree(ptr);
		printk("Removing Complete.\n");
	} */
    printk("Removing Module: BDLIST....\n");
    return;
}

module_init(simple_init);
module_exit(simple_exit);

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Simple Module");
MODULE_AUTHOR("My name");
