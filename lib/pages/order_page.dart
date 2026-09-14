import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nhac_lojas/components/container_nhac.dart';
import 'package:nhac_lojas/components/filter_tag.dart';
import 'package:nhac_lojas/components/icon_container.dart';
import 'package:nhac_lojas/controllers/scroll_shell_controller.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollShellController.of(context),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 46.h, 20.w, 110.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pedidos',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconContainer(
                  icon: Icons.search_rounded,
                ),
              ],
            ),
            SizedBox(height: 24.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const ListaFilterTags(
                    filtros: ['Todos', 'Confirmar', 'Em preparo', 'A caminho', 'Entregue'],
                    quantidades: [5, 1, 1, 1, 2],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: ContainerNhac(
                codigo: 1250,
                informacao: 'Maria Silva',
                quantidadeItens: 2,
                preco: 49.90,
                horario: '12:30',
                situacao: 'Em preparo',
                onTap: () => context.push('/order-details'),
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: ContainerNhac(
                codigo: 1249,
                informacao: 'João Pedro',
                quantidadeItens: 3,
                preco: 62.50,
                horario: '12:10',
                situacao: 'A caminho',
                onTap: () => context.push('/order-details'),
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: ContainerNhac(
                codigo: 1248,
                informacao: 'Ana Clara',
                quantidadeItens: 1,
                preco: 25.00,
                horario: '12:00',
                situacao: 'Entregue',
                onTap: () => context.push('/order-details'),
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: ContainerNhac(
                codigo: 1247,
                informacao: 'Lucas Martins',
                quantidadeItens: 2,
                preco: 33.00,
                horario: '11:45',
                situacao: 'Confirmar',
                onTap: () => context.push('/order-details'),
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: ContainerNhac(
                codigo: 1246,
                informacao: 'Fernanda Lima',
                quantidadeItens: 1,
                preco: 18.90,
                horario: '11:30',
                situacao: 'Entregue',
                onTap: () => context.push('/order-details'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}